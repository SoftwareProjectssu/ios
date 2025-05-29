import SwiftUI

struct MyPageView: View {
    @EnvironmentObject private var router: NavigationRouter
    @State private var nickname: String = "@nickname"
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
                            Image("HairLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 130, height: 42)
                                .padding(.horizontal, 38)
                            Spacer()
                        }
                        .padding(.bottom, 38)

                        // 닉네임 & 메뉴
                        HStack {
                            Text(nickname)
                                .font(.headline)
                            Spacer()
                            NavigationLink {
                                                 SettingView()
                                             } label: {
                                Image(systemName: "line.3.horizontal")
                                    .font(.title3)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .padding(.bottom, 38)

                        // 저장/염색한 머리 섹션
                        VStack(alignment: .leading, spacing: 16) {
                            HairSectionView(title: "저장한 머리", items: savedHair)
                            HairSectionView(title: "염색한 머리", items: dyedHair)
                                .padding(.top, 31)
                        }
                        .padding(.horizontal)

                        Spacer(minLength: 100) // CustomTabBar 공간 확보
                    }
                }
            }
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
                Button(action: {
                    // TODO: Navigate to detailed view
                }) {
                    Text("더보기")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                ForEach(items.indices, id: \.self) { _ in
                    Button(action: {
                        // TODO: Show hair detail
                    }) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
    }
}
