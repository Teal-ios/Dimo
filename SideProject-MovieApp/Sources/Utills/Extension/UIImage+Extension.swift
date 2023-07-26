//
//  UIImage+Extension.swift
//  SideProject-MovieApp
//
//  Created by 이병현 on 2023/07/26.
//

import UIKit

extension UIImage {
    func resizeImageTo(size: CGSize) -> UIImage? {
        // 비트맵 생성
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 비트맵 그래픽 배경에 이미지 다시 그리기
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        // 현재 비트맵 그래픽 배경에서 이미지 가져오기
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        // 비트맵 환경 제거
        UIGraphicsEndImageContext()
        // 크기가 조정된 이미지 반환
        return resizedImage
    }
}
