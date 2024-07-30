//
//  PhotoModel.swift
//  SwiftUIAd
//
//  Created by Yun Ni on 2024-07-30.
//

import Foundation

struct PhotoModel: Codable, Identifiable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
