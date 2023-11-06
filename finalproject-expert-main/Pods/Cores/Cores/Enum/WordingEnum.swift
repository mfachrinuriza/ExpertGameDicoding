//
//  WordingEnum.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import Foundation

public enum ServiceError {
    public static let deleteFavoriteFailed = "Menghapus game favorit Gagal!"
    public static let createFavoriteFailed = "Menambahkan game favorit Gagal!"
    public static let pleaseCheckConnectionError = "Koneksi sedang bermasalah, silakan cek kembali koneksimu"
}

public enum ServiceSuccess {
    public static let deleteFavoriteSuccess = "Menghapus game favorit Berhasil!"
    public static let createFavoriteSuccess = "Menambahkan game favorit Berhasil!"
    
}
