//
//  SignupView.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//

import SwiftUI
import Combine

struct SignupView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var nickname: String = ""
    @State private var sex: String = ""
    @State private var faceType: String = ""
    @State private var preferredStyle: String = ""
    @State private var isLoading: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @StateObject private var viewModel = SignupViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("회원가입")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)

            Group {
                customTextField(placeholder: "닉네임", text: $nickname)
                customTextField(placeholder: "성별", text: $sex)
                customTextField(placeholder: "얼굴형", text: $faceType)
                customTextField(placeholder: "선호하는 헤어스타일", text: $preferredStyle)
            }
            // Profile Photo Picker
            Button {
                showImagePicker = true
            } label: {
                if let img = selectedImage {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 313, height: 313)
                        .clipped()
                        .cornerRadius(8)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 2)
                        .frame(width: 313, height: 313)
                        .overlay(
                            Text("프로필 사진 선택")
                                .foregroundColor(.gray)
                        )
                }
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showImagePicker) {
                ImagePicker { image in
                    selectedImage = image
                }
            }
            .padding(.bottom, 20)

            Button(action: {
                print("🚀 SignupView: Confirm button tapped")
                isLoading = true
                // sync ViewModel inputs
                viewModel.nickname = nickname
                viewModel.sex = sex
                viewModel.faceType = faceType
                viewModel.selectedImage = selectedImage

                viewModel.signup { success in
                    DispatchQueue.main.async {
                        print("🔔 SignupView: signup completion returned \(success)")
                        isLoading = false
                        if success {
                            print("🎉 SignupView: routing to home")
                            router.toHome()
                        }
                    }
                }
            }) {
                Text("확인")
                    .foregroundColor(.white)
                    .frame(width: 313, height: 67)
                    .background(isLoading ? Color.gray : Color.blue)
                    .cornerRadius(15)
            }
            .disabled(isLoading)

            Spacer()
        }
        .padding(.horizontal, 20)
    }

    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(.horizontal)
            .frame(width: 313, height: 67)
            .background(Color(.systemGray6))
            .cornerRadius(15)
    }
}

#Preview {
    SignupView().environmentObject(NavigationRouter())
}
