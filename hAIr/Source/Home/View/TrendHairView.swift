import SwiftUI

struct TrendHairView: View {
    @ObservedObject var viewModel: TrendHairViewModel
    @State private var showCard: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Text("에디터가 추천하는 최신 유행 머리스타일")
                .font(.pretendard(.semibold, size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 32)

            TabView(selection: $viewModel.currentPage) {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    ZStack(alignment: .bottom) {
                        Image(viewModel.items[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 400)
                            .clipped()
                            .cornerRadius(12)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showCard = true
                                }
                            }

                        Text(viewModel.items[index].description)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                            .padding(.bottom, 12)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 420)
            .padding()

            HStack(spacing: 8) {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    Circle()
                        .fill(index == viewModel.currentPage ? Color.navy : Color.buttongray)
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 32)
        }
        .overlay(
            Group {
                if showCard {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showCard = false
                            }
                        }
                        .zIndex(1)

                    TrendHairCardView(item: viewModel.items[viewModel.currentPage])
                        .transition(.move(edge: .bottom))
                        .offset(y: 200)
                        .zIndex(2)
                }
            }
        )
        .ignoresSafeArea(edges: .bottom)
    }
}
