//
//  Constants.swift
//  MobileApps
//
//  Created by Abdul Rahim on 11/10/21.
//

import Foundation

// MARK:- Common Error messages
struct Constants {
    
    //  firestore db references
    struct FireStore {
        struct Collections {
            static let FavouriteMobiles = "FavouriteMobiles"
        }
    }
    
    // Error messages for conectivity
    struct ErrorMessage {
        static let kNoInternetTitle = "No Internet Connectivity!"
        static let kConnectivityError = "Please check your internet connectivity and try again later."
        static let kSomethingWentWrong = "Something went wrong. Please try again later."
        static let kSuccessMessage = "Success"
        static let kWaitForPost = "Please wait..."
    }
    
    
    struct Message {
        static  let addedToFavourite = "Mobile has been added to favourite list"
        static  let deleteFromList = "Mobile has been deleted from favourite list"
    }

}
