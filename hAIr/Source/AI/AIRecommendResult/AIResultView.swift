//  AIResultView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.

import SwiftUI

struct AIResultView: View {
    @Environment(\.dismiss) var dismiss
    let photoURL: String
    @State private var selectedHair: AIHairViewModel?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)

            Text("A.I 추천 결과")
                .font(.system(size: 24, weight: .semibold))
                .padding(.bottom, 45)
                .padding(.top, 16)
                .frame(maxWidth: .infinity, alignment: .center)

            VStack {
                Button(action: {
                    print(" 선택된 헤어스타일")
                    selectedHair = AIHairViewModel(hairId: 0) // 하나만 선택 가능
                }) {
                    AsyncImage(url: URL(string: photoURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 313, height: 313)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 313, height: 313)
                                .clipped()
                                .cornerRadius(8)
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 313, height: 313)
                                .cornerRadius(8)
                                .overlay(Text("이미지 로드 실패").font(.caption))
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)

            // 추가된 버튼 HStack
            HStack(spacing: 16) {
                Button(action: {
                    showRecommendationSheet = true
                }) {
                    Text("추천받은 머리 보러가기")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.7))
                        .cornerRadius(25)
                }

                Button(action: {
                    showColoringSheet = true
                }) {
                    Text("염색하러가기")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.7))
                        .cornerRadius(25)
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(item: $selectedHair) { viewModel in
            ApplyingLoadingView(viewModel: viewModel)
        }
        .sheet(isPresented: $showRecommendationSheet) {
            HairRecommendationView()
        }
        .sheet(isPresented: $showColoringSheet) {
            HairColoringView()
        }
    }
    // State for sheets
    @State private var showRecommendationSheet = false
    @State private var showColoringSheet = false
}

#Preview {
    AIResultView(photoURL: "https://example.com/dummy.jpg")
}

// Dummy views for navigation
struct HairRecommendationView: View {
    var body: some View {
        Text("추천받은 머리 보러가기 화면")
            .font(.title)
            .padding()
    }
}

struct HairColoringView: View {
    var body: some View {
        Text("염색하러가기 화면")
            .font(.title)
            .padding()
    }
}
