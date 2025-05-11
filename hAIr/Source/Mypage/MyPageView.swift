//
//  MyPageView.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import SwiftUI

struct MyPageView: View {
    let savedHair: [String] = Array(repeating: "", count: 3)
    let dyedHair: [String] = Array(repeating: "", count: 3)

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        // 로고
                        Spacer(minLength: 63)
                        HStack {
                            Spacer()
                            Image("HairLogo") // 직접 넣는 로고
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130,height: 42)
                            Spacer()
                        }

                        // 닉네임 & 메뉴
                        HStack {
                            Text("@nick_name")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                // 메뉴 열기 액션
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .font(.title3)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)

                        VStack(alignment: .leading, spacing: 16) {
                            HairSectionView(title: "저장한 머리", items: savedHair)
                            HairSectionView(title: "염색한 머리", items: dyedHair)
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 100) // CustomTabBar 공간 확보
                    }
                }
            }
            CustomTabBar()
        }
    }
}

struct HairSectionView: View {
    let title: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Text("더보기")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                ForEach(items.indices, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}

#Preview {
    MyPageView()
}

struct CustomTabBar: View {
    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<4) { index in
                Button(action: {
                    // 탭 전환 액션
                }) {
                    Image(systemName: getIconName(for: index))
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray) // 선택된 탭 처리 필요시 분기
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
            }
        }
        .frame(height: 83)
        .background(Color.white)
        .shadow(color: .black.opacity(0.05), radius: 5, y: -2)
    }

    private func getIconName(for index: Int) -> String {
        switch index {
        case 0: return "home"
        case 1: return "ai"
        case 2: return "myhair"
        case 3: return "mypage"
        default: return "circle"
        }
    }
}
