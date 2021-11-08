// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Plural format key: "%#@VARIABLE@"
  internal static func ageValue(_ p1: Int) -> String {
    return L10n.tr("Localizable", "age-value", p1)
  }

  internal enum Action {
    /// Удалить
    internal static let delete = L10n.tr("Localizable", "action.delete")
  }

  internal enum Address {
    /// Адрес доставки
    internal static let title = L10n.tr("Localizable", "address.title")
  }

  internal enum Apartment {
    /// Квартира
    internal static let title = L10n.tr("Localizable", "apartment.title")
  }

  internal enum Auth {
    /// Войти
    internal static let action = L10n.tr("Localizable", "auth.action")
    /// Логин
    internal static let login = L10n.tr("Localizable", "auth.login")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "auth.password")
  }

  internal enum Catalog {
    /// Купить
    internal static let buy = L10n.tr("Localizable", "catalog.buy")
    /// Каталог
    internal static let title = L10n.tr("Localizable", "catalog.title")
  }

  internal enum Checkout {
    /// Купить за
    internal static let buy = L10n.tr("Localizable", "checkout.buy")
    /// Оформить заказ
    internal static let title = L10n.tr("Localizable", "checkout.title")
    internal enum CreateOrder {
      /// Заказ успешно оформлен
      internal static let success = L10n.tr("Localizable", "checkout.createOrder.success")
    }
  }

  internal enum Common {
    /// Назад
    internal static let back = L10n.tr("Localizable", "common.back")
    /// Поле пустое
    internal static let emptyField = L10n.tr("Localizable", "common.emptyField")
    /// Что-то пошло не так
    internal static let error = L10n.tr("Localizable", "common.error")
    /// от
    internal static let from = L10n.tr("Localizable", "common.from")
    /// в
    internal static let `in` = L10n.tr("Localizable", "common.in")
  }

  internal enum DeliveryDate {
    /// Дата доставки
    internal static let title = L10n.tr("Localizable", "deliveryDate.title")
  }

  internal enum History {
    /// Мои заказы
    internal static let title = L10n.tr("Localizable", "history.title")
  }

  internal enum OrderCancelled {
    /// Отменен
    internal static let title = L10n.tr("Localizable", "orderCancelled.title")
  }

  internal enum OrderInWork {
    /// В работе
    internal static let title = L10n.tr("Localizable", "orderInWork.title")
  }

  internal enum OrderNumber {
    /// Заказ №
    internal static let title = L10n.tr("Localizable", "orderNumber.title")
  }

  internal enum Product {
    /// Купить сейчас
    internal static let buyNow = L10n.tr("Localizable", "product.buyNow")
  }

  internal enum Profile {
    /// Выйти
    internal static let exit = L10n.tr("Localizable", "profile.exit")
    /// Мои заказы
    internal static let myOrders = L10n.tr("Localizable", "profile.myOrders")
    /// Профиль
    internal static let title = L10n.tr("Localizable", "profile.title")
  }

  internal enum SegmentedControl {
    /// Активные
    internal static let active = L10n.tr("Localizable", "segmentedControl.active")
    /// Все
    internal static let all = L10n.tr("Localizable", "segmentedControl.all")
  }

  internal enum Settings {
    /// Другой род деятельности
    internal static let anotherOccupation = L10n.tr("Localizable", "settings.anotherOccupation")
    /// Изменить
    internal static let buttonChange = L10n.tr("Localizable", "settings.buttonChange")
    /// Имя
    internal static let name = L10n.tr("Localizable", "settings.name")
    /// Род деятельности
    internal static let surname = L10n.tr("Localizable", "settings.surname")
    /// Настройки
    internal static let title = L10n.tr("Localizable", "settings.title")
    internal enum Snacker {
      /// Во время изменения профиля произошла ошибка
      internal static let error = L10n.tr("Localizable", "settings.snacker.error")
      /// Профиль был успешно изменен
      internal static let success = L10n.tr("Localizable", "settings.snacker.success")
    }
  }

  internal enum Specialization {
    /// Другое
    internal static let another = L10n.tr("Localizable", "specialization.another")
    /// Разработчик
    internal static let developer = L10n.tr("Localizable", "specialization.developer")
    /// Тестировщик
    internal static let tester = L10n.tr("Localizable", "specialization.tester")
    /// Тракторист
    internal static let tractorDriver = L10n.tr("Localizable", "specialization.tractorDriver")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
