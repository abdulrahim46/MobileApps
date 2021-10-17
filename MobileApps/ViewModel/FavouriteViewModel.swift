//
//  FavouriteViewModel.swift
//  MobileApps
//
//  Created by Abdul Rahim on 16/10/21.
//

import Foundation
import Firebase

class FavouriteViewModel {
    
    // Properties for firebase
    let dbCollection = Firestore.firestore().collection(Constants.FireStore.Collections.FavouriteMobiles)
    
    var mobiles = [Mobile]()
    
    /// saving favourite  places to firestore
    func saveFavouriteMobile(mobile: Mobile) {
        let data = [
            "id": mobile.id.orZero,
            "thumbImageURL": mobile.image.orEmpty,
            "name": mobile.title.orEmpty,
            "price": mobile.price.orZero,
            "description": mobile.description.orEmpty,
            "rating": mobile.rating.orZero] as [String : Any]
        
        /// Creating Document Reference
        let docRef = dbCollection.whereField("favouriteMobile", isEqualTo: mobile.id.orZero).limit(to: 1)
        
        /// Checking if user has already favourite mobile at current index
        docRef.getDocuments { [weak self] (querysnapshot, error) in
            if error != nil {
                AlertBuilder.failureAlertWithMessage(message: error?.localizedDescription ?? "Could not connect to Database")
            } else {
                if let doc = querysnapshot?.documents, !doc.isEmpty {
                    /// Mobile is already present
                    return
                } else {
                    /// Adding picture to LikedPhotos DataBase
                    self?.dbCollection.document().setData(data) { (error) in
                        if error != nil {
                            AlertBuilder.failureAlertWithMessage(message: error?.localizedDescription ?? "Could not add image to Database")
                        } else {
                            AlertBuilder.successAlertWithMessage(message: Constants.Message.addedToFavourite)
                        }
                    }
                }
            }
        }
    }
    
    /// Getting all favourite mobiles of user from FireStore
    func getFavouriteMobile() {
        
        /// get getdocument  snapshot from firestore & decode
        dbCollection.getDocuments { [weak self] (snapShot, error) in

            guard let self = self else { return }
            
            if let error = error {
                AlertBuilder.failureAlertWithMessage(message: error.localizedDescription)

            } else if let snapShot = snapShot {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                snapShot.documents.forEach { (document) in
                    if var mobile = try? decoder.decode(Mobile.self, fromJSONObject: document.data()) {
                        mobile.documentID = document.documentID
                        self.mobiles.append(mobile)
                    }
                }
            }
        }
    }
    
    /// delete data from firestore
    func removeFavouriteMobile(mobile: Mobile?) {
        dbCollection.document().collection("favouriteMobile").document(mobile?.documentID ?? "").delete(completion: { (error) in
            if error != nil {
                AlertBuilder.failureAlertWithMessage(message: error?.localizedDescription ?? "Could not delete from Database")
            } else {
                AlertBuilder.successAlertWithMessage(message: Constants.Message.deleteFromList)
            }
        })
    }
    
}
