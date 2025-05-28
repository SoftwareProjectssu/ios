import SwiftUI
import Combine

struct SignupView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var nickname: String = ""
    @State private var nicknameError: String? = nil
    @State private var sex: String = ""
    @State private var faceType: String = ""
    @State private var preferredStyle: String = ""
    @State private var isLoading: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @StateObject private var viewModel = SignupViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("회원가입")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)

                Group {
                    customTextField(placeholder: "닉네임은 6자 이하로 해주세요", text: $nickname)
                    if let error = nicknameError {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            GenderButton(title: "남자", isSelected: sex == "남자") {
                                sex = "남자"
                            }
                            .frame(maxWidth: .infinity)

                            GenderButton(title: "여자", isSelected: sex == "여자") {
                                sex = "여자"
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(height: 67)
                    }

                    customTextField(placeholder: "얼굴형", text: $faceType)
                    customTextField(placeholder: "선호하는 헤어스타일", text: $preferredStyle)
                }

                Button {
                    showImagePicker = true
                } label: {
                    ZStack {
                        if let img = selectedImage {
                            ZStack {
                                Color.white
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 313)
                                    .clipped()
                                    .cornerRadius(8)
                            }
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("navy"), lineWidth: 2)
                                .frame(maxWidth: .infinity)
                                .frame(height: 313)
                                .overlay(
                                    Text("프로필 사진 선택")
                                        .foregroundColor(Color("navy"))
                                )
                        }
                    }
                    .background(Color.white)
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    ImagePicker { image, _ in
                        selectedImage = image
                    }
                }

                Button(action: {
                    guard nickname.count <= 6 else {
                        nicknameError = "닉네임은 6자 이하로 해주세요!"
                        return
                    }

                    nicknameError = nil
                    print("🚀 SignupView: Confirm button tapped")
                    isLoading = true

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
                                UserDefaults.standard.set(true, forKey: "hasSignedUp")
                                router.toHome()
                            }
                        }
                    }
                }) {
                    Text("회원가입 완료")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 67)
                        .background(isLoading ? Color.gray : Color("navy"))
                        .cornerRadius(15)
                }
                .disabled(isLoading)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .frame(minHeight: UIScreen.main.bounds.height)
        }
        .scrollDismissesKeyboard(.interactively)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }

    func customTextField(placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 67)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .submitLabel(.done)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}

// MARK: - GenderButton

struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .white : .black)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(isSelected ? Color("navy") : Color(.systemGray5))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(isSelected ? Color("navy") : Color.gray, lineWidth: isSelected ? 0 : 1)
                )
        }
    }
}

// MARK: - Preview

#Preview {
    SignupView().environmentObject(NavigationRouter())
}
