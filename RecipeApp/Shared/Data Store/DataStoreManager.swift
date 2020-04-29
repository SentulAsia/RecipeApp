//
//  DataStoreManager.swift
//  RecipeApp
//
//  Created by Zaid Said on 28/04/2020.
//  Copyright © 2020 Zaid M. Said. All rights reserved.
//

import Foundation

class DataStoreManager {

    // MARK: - Singleton

    static let shared = DataStoreManager()

    private init() {}

    // MARK: - Keys

    enum Keys {
        static let schemaVersion = "kSchemaVersion"
        static let recipeNames = "kRecipeNames"
        static let recipes = "kRecipe" // the recipe name are appended to get unique key
        static let recipeImages = "kImage" // the recipe name are appended to get unique key
    }

    // MARK: - Properties

    lazy var addNewRecipeWorker = AddNewRecipeWorker() // Used to seed the recipe

    let currentSchemaVersion = 1 // Bump this version if there is a migration added

    /// The schema version based on last migration performed
    var schemaVersion: Int {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.integer(forKey: Keys.schemaVersion)
    }

    // MARK: - Methods

    /// Read object from storage
    ///
    /// - Parameters:
    ///   - key: The object storage key
    ///   - completion: Completion handler when object is obtained from storage
    ///
    /// Completion handler is used instead of return because we might change the storage to non real time storage later on; i.e
    /// `CloudKit` so we don't have to change the code at implementation part.
    func read(for key: String, completion: @escaping (_ object: Any?) -> Void) {
        UserDefaults.standard.synchronize()
        let object = UserDefaults.standard.object(forKey: key)
        completion(object)
    }

    /// Write object to storage
    ///
    /// - Parameters:
    ///   - value: Object to be stored
    ///   - key: The object storage key
    ///   - completion: Optional completion handler with `isSuccessful` flag.
    func write(value: Any, for key: String, completion: ((_ isSuccessful:Bool) -> Void)? = nil) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
        completion?(true)
    }

    /// Delete all stored objects in storage
    ///
    /// - Parameter completion: Optional completion handler with `isSuccessful` flag.
    ///
    /// Used in unit test to flush the storage
    func deleteAll(completion: ((_ isSuccessful:Bool) -> Void)? = nil) {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            completion?(false)
            return
        }

        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        UserDefaults.standard.synchronize()
        completion?(true)
    }

    /// Migrate schema to the latest version
    ///
    /// - Parameter completion: completion handler with `isSuccessful` flag.
    ///
    /// Data Store version control to make sure user will always have the same persistant data regardless which version of the app used.
    /// If we need to change the data structure or storage type, simply add case of the new version, do migration code to migrate to the
    /// new data store version with `fallthrough` to make sure each migration is executed. Then bump `currentSchemaVersion`
    /// by one to make sure existing user app perform the migration.
    ///
    /// TODO: migrate UserDefaults to Core Data so that the data structure becomes clean.
    func migrateSchema(completion: ((_ isSuccessful:Bool) -> Void)? = nil) {
        let oldSchemaVersion = schemaVersion
        let newSchemaVersion = currentSchemaVersion

        let semaphore = DispatchSemaphore(value: 0)
        let dispatchQueue = DispatchQueue.global(qos: .background)

        if oldSchemaVersion < newSchemaVersion {

            dispatchQueue.async { [weak self] in
                // migrate based on version
                switch oldSchemaVersion {

                /*
                     v0 -> v1:

                     Seed Recipe
                 */
                case 0:
                    _ = self?.seeds(completion: { (isSuccessful) in
                        semaphore.signal()
                    })
                    _ = semaphore.wait(timeout: .distantFuture)

                default:
                    break
                }

                DispatchQueue.main.async {
                    // update the schema version
                    UserDefaults.standard.set(newSchemaVersion, forKey: Keys.schemaVersion)
                    UserDefaults.standard.synchronize()

                    completion?(true)
                }
            }

        } else if oldSchemaVersion > newSchemaVersion {
            print("The oldSchemaVersion is \(oldSchemaVersion), newSchemaVersion is \(newSchemaVersion).")
            completion?(false)

        } else {
            completion?(true)
        }
    }
}
