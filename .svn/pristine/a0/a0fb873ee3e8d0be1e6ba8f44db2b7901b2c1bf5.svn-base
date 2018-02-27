//
//  ZXEditProfileViewController+Delegate.swift
//  YDHYK
//
//  Created by 120v on 2017/11/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

//MARK: - UITableView
extension ZXEditProfileViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10.0
        }
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0://头像
                self.setupUserHeadPortraits()
            case 1:
                self.performSegue(withIdentifier: ZXEditNameViewController.ModifyName_Segue, sender: nil)
            case 2:
                let sexView: ZXPopView = ZXPopView.loadNib()
                sexView.delegate = self
                sexView.flag = ZXPopView.PopViewFlag.Sex
                ZXRootController.appWindow()?.addSubview(sexView)
                sexView.loadData(self.sexArray,"性别",self.sex.text!)
            case 3:
                let sexView: ZXPopView = ZXPopView.loadNib()
                sexView.delegate = self
                sexView.flag = ZXPopView.PopViewFlag.Age
                ZXRootController.appWindow()?.addSubview(sexView)
                sexView.loadData(self.ageArray,"年龄",self.age.text!)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                self.performSegue(withIdentifier: ZXMyAddressViewController.MyAddress_Segue, sender: nil)
            case 1:
                break
            default:
                break
            }
        default:
            break
        }
    }
}

//MARK: - UITableView
extension ZXEditProfileViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true) {
            
            let portraitImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let resultImage = UIImage.imageByScalingToMaxSize(sourceImage: portraitImage)
            
            let cropperVC: ZXImageCropperViewController = ZXImageCropperViewController.init(originalImage: resultImage, cropFrame: CGRect.init(x: 0, y: 100, width: ZXBOUNDS_WIDTH, height: ZXBOUNDS_WIDTH), limitScaleRatio: 3.0)
            cropperVC.delegate = self
            self.present(cropperVC, animated: true, completion: nil)
        }
    }
}


extension ZXEditProfileViewController: RBImageCropperDelegate {
    func imageCropperDidCancel(_ cropperViewController: ZXImageCropperViewController) {
        cropperViewController.dismiss(animated: true, completion: nil)
    }
    
    func imageCropper(_ cropperViewController: ZXImageCropperViewController, didFinished editImg: UIImage) {
        //2.上传服务器
        self.requestForUpdateHeadImageFile(headImg: editImg)
        
        cropperViewController.dismiss(animated: true, completion: nil)
    }
}

extension ZXEditProfileViewController: ZXPopViewDelegate {
    func didSelectedPopViewCell(_ str: String, _ flag: Int) {
        if flag == ZXPopView.PopViewFlag.Sex {
            var sex: Int = -1
            if str == "男" {
                sex = 1
            }else if str == "女" {
                sex = 0
            }
            self.requestForModiySex(sex)
        }else if flag == ZXPopView.PopViewFlag.Age {
            var ageGroup: Int = -1
            
            if str == "20岁以下" {
                ageGroup = 0
            }
            
            if str == "20-30岁" {
                ageGroup = 1
            }
            
            if str == "30-40岁" {
                ageGroup = 2
            }
            
            if str == "40-50岁" {
                ageGroup = 3
            }
            
            if str == "50岁以上" {
                ageGroup = 4
            }
            self.requestForModiyAgeGroup(ageGroup,str)
        }
    }
}
