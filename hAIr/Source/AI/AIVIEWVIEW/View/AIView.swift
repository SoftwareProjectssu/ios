import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        picker.modalPresentationStyle = .fullScreen
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let onImagePicked: (UIImage) -> Void

        init(onImagePicked: @escaping (UIImage) -> Void) {
            self.onImagePicked = onImagePicked
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                onImagePicked(image)
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct AIView: View {
    @StateObject private var viewModel = AIViewModel()
    @State private var rawImage: UIImage? = nil
    @State private var isCropping: Bool = false
    @State private var isNavigatingToLoading = false
    @State private var isShowingResultView = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 63) {
                Spacer().frame(height: 80)

                // 사진 업로드 버튼
                Button {
                    viewModel.showSourceActionSheet = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.navy.opacity(0.6), lineWidth: 3)
                            .frame(width: 313, height: 313)

                        if let image = viewModel.selectedImage {
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 313, height: 313)
                                    .clipped()
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        rawImage = image
                                        isCropping = true
                                    }

                                Button(action: {
                                    viewModel.selectedImage = nil
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.gray)
                                        .background(Color.white.clipShape(Circle()))
                                        .padding(8)
                                }
                            }
                        } else {
                            VStack(spacing: 8) {
                                Image(systemName: "camera.fill.badge.ellipsis")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)

                                Text("사진 업로드하기")
                                    .font(.pretendard(.semibold, size: 15))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
                .confirmationDialog("사진을 어디서 가져올까요?", isPresented: $viewModel.showSourceActionSheet, titleVisibility: .visible) {
                    Button("카메라로 촬영") {
                        viewModel.presentCamera()
                    }
                    Button("사진 보관함에서 선택") {
                        viewModel.isImagePickerPresented = true
                    }
                    Button("취소", role: .cancel) {}
                }

                // AI 추천 버튼
                Button(action: {
                    isNavigatingToLoading = true
                }) {
                    Text("AI에게 머리 추천 받기")
                        .font(.pretendard(.semibold, size: 16))
                        .foregroundColor(.white)
                        .frame(width: 313, height: 54)
                        .background(viewModel.selectedImage == nil ? Color.gray : Color.navy)
                        .cornerRadius(28)
                }
                .disabled(viewModel.selectedImage == nil)
                .padding(.bottom, 130)

                Spacer()
            }
            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                ImagePicker { image in
                    rawImage = image
                    isCropping = true
                }
            }
            .fullScreenCover(isPresented: $isCropping) {
                if let rawImage {
                    CropView(image: rawImage) { cropped in
                        viewModel.selectedImage = cropped
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigatingToLoading) {
                LoadingView {
                    isShowingResultView = true
                }
            }
            .navigationDestination(isPresented: $isShowingResultView) {
                AIResultView()
            }
        }
    }
}

#Preview {
    AIView()
}
