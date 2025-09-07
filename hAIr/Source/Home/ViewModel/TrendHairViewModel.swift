//
//  TrendHairViewModel.swift
//  hAIr
//
//  Created by 한태빈 on 5/8/25.
//

import SwiftUI

final class TrendHairViewModel: ObservableObject {
    @Published var currentPage: Int = 0

    let items: [TrendHairItem] = [
        TrendHairItem(
            imageName: "trend1",
            description: "가르마펌",
            detail: "얼굴형에 맞게 5:5 혹은 6:4 등으로 나눈 가르마를 중심으로 자연스럽게 웨이브를 준 펌 스타일입니다. 이마를 드러내면서 세련되고 성숙한 이미지를 연출할 수 있습니다."
        ),
        TrendHairItem(
            imageName: "trend2",
            description: "가일컷",
            detail: "머리에 각을 주어 마치 부채꼴 모양으로 가르마를 연출하는 스타일입니다. 기장과 스타일링에 따라 클래식과 캐쥬얼 분위기를 모두 낼 수 있는 장점을 가지는 헤어스타일입니다."
        ),
        TrendHairItem(
            imageName: "trend3",
            description: "리프컷",
            detail: "잎사귀 모양처럼 머리카락에 레이어를 층층이 넣어 자연스럽고 부드러운 실루엣을 만들어주는 스타일입니다. 머리카락이 얼굴선을 따라 흘러 매력적이고 부드러운 분위기를 만들어줍니다."
        ),
        TrendHairItem(
            imageName: "trend4",
            description: "히피펌",
            detail: "가는 웨이브나 꼬불꼬불한 컬이 전체적으로 들어가 볼륨감이 풍부한 스타일입니다. 자유롭고 개성있는 무드를 낼 수 있으며 빈티지 감성을 표현할 수 있습니다."
        )
    ]

}
