//
//  WorkspaceAddViewController.swift
//  Purple
//
//  Created by Seungyeon Kim on 1/15/24.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

final class WorkspaceAddViewController: BaseViewController {
    
    let mainView = WorkspaceAddView()
    let viewModel = WorkspaceAddViewModel()
    
    let disposeBag = DisposeBag()
    
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        bind()
    }
    
    func bind() {
        
        let input = WorkspaceAddViewModel.Input(
            nameText:
                mainView.writeSectionView
                .workspaceNameTextfield.rx.text.orEmpty,
            descriptionText:
                mainView.writeSectionView
                .workspaceDescriptionTextfield.rx.text.orEmpty, 
            //imageInput: mainView.writeSectionView.profileImageView.rx.image
            cameraTap:
                mainView.writeSectionView
                .cameraButton.rx.tap,
            completeTap:
                mainView.writeSectionView
                .completeButton.rx.tap,
            closeTap:
                mainView.presentNavigationBarView.closeButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        //MARK: - 완료 버튼
        
        output.nameValidation
            .bind(to: self.mainView.writeSectionView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.nameValidation
            .subscribe(with: self) { owner, value in
                if value {
                    
                    self.mainView.writeSectionView.completeButton.backgroundColor = value ? .brandPurple : .brandInactive

                }
            }
            .disposed(by: disposeBag)
        
        output.completeTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    let vc = CustomTabbarViewController()
                    self.view.window?.rootViewController = vc
                }

            }
            .disposed(by: disposeBag)
        
        
        //MARK: - 카메라 버튼
        
        //카메라 버튼 누름
        output.cameraTapped
            .subscribe(with: self) { owner, value in
                
                //PHPicker 띄움
                if value {
                    
                    var configuration = PHPickerConfiguration()
                    configuration.selectionLimit = 1
                    configuration.filter = .images
                    
                    let picker = PHPickerViewController(configuration: configuration)
                    picker.delegate = self
                    
                    self.present(picker, animated: true, completion: nil)
                    
                }
                
            }
            .disposed(by: disposeBag)
        
        //MARK: - 닫기버튼
        
        output.closeTapped
            .subscribe(with: self) { owner, value in
                
                if value {
                    self.dismiss(animated: true)
                }
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
}

//MARK: - 이미지

extension WorkspaceAddViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage{
                                        
                    DispatchQueue.main.async {
                        self.mainView.writeSectionView.profileImageView.image = image
                        self.mainView.writeSectionView.profileIconView.image = nil
                    }
                }
            }
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
