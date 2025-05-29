import SwiftUI

struct MyPageView: View {
    @EnvironmentObject private var router: NavigationRouter
    @State private var nickname: String = "@nickname"

    @StateObject private var savedHairVM = SavedHairViewModel()
    @StateObject private var dyedHairVM = DyedHairViewModel()

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

                        // 저장한 머리 섹션
                        VStack(alignment: .leading) {
                            HStack {
                                Text("저장한 머리")
                                    .font(.headline)
                                Spacer()
                                NavigationLink(destination: SavedHairView(viewModel: SavedHairViewModel())) {
                                    Text("더보기")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                                ForEach(savedHairVM.items.prefix(3)) { hair in
                                    Image(hair.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:112, height: 132)
                                        .clipped()
                                        .cornerRadius(4)
                                }
                            }
                        }
                        .padding(.horizontal)

                        // 염색한 머리 섹션
                        VStack(alignment: .leading) {
                            HStack {
                                Text("염색한 머리")
                                    .font(.headline)
                                Spacer()
                                NavigationLink(destination: DyedHairView(viewModel: DyedHairViewModel())) {
                                    Text("더보기")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                                ForEach(dyedHairVM.items.prefix(3)) { hair in
                                    Image(hair.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:112, height: 132)
                                        .clipped()
                                        .cornerRadius(4)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 31)

                        Spacer(minLength: 100) // CustomTabBar 공간 확보
                    }
                }
            }
        }
    }
}
