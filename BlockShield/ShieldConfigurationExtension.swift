//
//  ShieldConfigurationExtension.swift
//  BlockShield
//
//  Created by 吉江恵 on 2024/06/03.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration (shielding application: Application) -> ShieldConfiguration {
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.light,
            backgroundColor: UIColor.white,
            icon: UIImage(systemName: "lock.shield"),
            title: ShieldConfiguration.Label(
                text: "Block To Do によってロック中",
                color: .black
            ),
            subtitle: ShieldConfiguration.Label(
                text: "解除するにはタスクを完了させましょう。",
                color: .black
            ),
            primaryButtonLabel: ShieldConfiguration.Label(
                text: "とじる",
                color: .white
            ),
            primaryButtonBackgroundColor: .systemIndigo
        )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}
