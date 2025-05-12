
import SwiftUI

final class ApplyHairViewModel: ObservableObject {
    @Published var currentPage: Int = 0

    let items: [ApplyHairItem] = [
        ApplyHairItem(
            imageName: "apply1",
            description: "히피펌",
            detail: "얇고 잔잔한 물결 웨이브를 전체적으로 넣은 내추럴하고 빈티지한 스타일입니다. 볼륨감과 개성을 살려 발랄하고 자유로운 분위기를 연출할 수 있습니다."
        ),
        ApplyHairItem(
            imageName: "apply2",
            description: "단발레이어드컷",
            detail: "턱선부터 어깨까지 층을 자연스럽게 준 가볍고 볼륨감 있는 단발 스타일입니다. 무거워 보일 수 있는 단발에 생동감을 더해 세련되고 시크한 이미지를 완성합니다."
        ),
        ApplyHairItem(
            imageName: "apply3",
            description: "단발c컬",
            detail: "웨이브를 한 번만 넣어 끝부분만 C자 형태로 말아 넣은 단정한 단발 스타일입니다. 얼굴선을 부드럽게 감싸주며 단아하고 여성스러운 인상을 줍니다."
        ),
        ApplyHairItem(
            imageName: "apply4",
            description: "장발s컬",
            detail: "길고 풍성한 머리에 굵은 S자 웨이브를 넣은 우아한 스타일입니다. 풍성한 볼륨과 부드러운 곡선으로 성숙하고 세련된 분위기를 연출합니다."
        )
    ]

}
