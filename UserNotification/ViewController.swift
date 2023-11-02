


import UIKit
import UserNotifications

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.checkTime()
        }
        
    }

    func checkTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        let currentTime = dateFormatter.string(from: Date())

        if isPalindrome(currentTime) || hasRepeatingDigits(currentTime) {
            sendNotification()
        }
    }

    func isPalindrome(_ text: String) -> Bool {
        return text == String(text.reversed())
    }

    func hasRepeatingDigits(_ text: String) -> Bool {
        for char in text {
            if text.filter({ $0 == char }).count >= 3 {
                return true
            }
        }
        return false
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Уведомление"
        content.body = "Текущее время интересное: \(Date())"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "TimeNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при отправке уведомления: \(error)")
            } else {
                print("Уведомление отправлено")
            }
        }
    }
}

