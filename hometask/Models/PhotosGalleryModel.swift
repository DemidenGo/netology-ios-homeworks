//
//  PhotosGalleryModel.swift
//  hometask
//
//  Created by Юрий Демиденко on 04.05.2022.
//

import UIKit

struct PhotosGalleryModel {

    let image: String

    static func makeMockModel() -> [PhotosGalleryModel] {

        var model = [PhotosGalleryModel]()

        for number in 1...20 {
            model.append(PhotosGalleryModel(image: "pic\(number)"))
        }

        return model
    }
}
