//
//  SnackbarFactory.swift
//  SchoolStore
//
//  Created by a1 on 01.10.2021.
//

import TTGSnackbar
import UIKit

enum SnackbarFactory {
    static func buildLogOutSnackbar() -> TTGSnackbar {
        let snackbar = TTGSnackbar(message: "Вы действительно хотите выйти?", duration: .forever)

        snackbar.actionText = "Да"
        snackbar.actionTextColor = .green
        snackbar.actionBlock = { (snackbar) in self.logOut() }

        snackbar.secondActionText = "Нет"
        snackbar.secondActionTextColor = .red
        snackbar.secondActionBlock = { (snackbar) in snackbar.dismiss() }

        return snackbar
    }
    
    //Возможные снакбары
    static func buildAuthErrorSnackbar() -> TTGSnackbar {
        let snackbar = TTGSnackbar(message: "Неправильный логин или пароль", duration: .middle)
        return snackbar
    }
    
    static func buildAddToCartSnackbar() -> TTGSnackbar {
        let snackbar = TTGSnackbar(message: "Товар успешно добавлен в корзину!", duration: .short)
        snackbar.animationType = .slideFromLeftToRight
        return snackbar
    }
    
    static func buildSuccPaymentSnackbar() -> TTGSnackbar {
        let snackbar = TTGSnackbar(message: "Оплата прошла успешно!", duration: .short)
        snackbar.animationType = .slideFromLeftToRight
        return snackbar
    }
    
    private static func logOut() {
        let dataService = DataServiceImpl()
        dataService.appState.accessToken = nil
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }
}
