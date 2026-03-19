import Foundation
import StoreKit

class StoreManager: ObservableObject {
    @Published var isPurchasing = false
    
    private let productID = "com.patternbreaker.premium"
    
    func purchasePremium(completion: @escaping () -> Void) {
        isPurchasing = true
        
        let request = SKProductsRequest(productIdentifiers: [productID])
        let delegate = StoreDelegate(completion: { [weak self] success in
            DispatchQueue.main.async {
                self?.isPurchasing = false
                if success {
                    completion()
                }
            }
        })
        request.delegate = delegate
        objc_setAssociatedObject(request, "delegate", delegate, .OBJC_ASSOCIATION_RETAIN)
        request.start()
    }
    
    func restore(completion: @escaping () -> Void) {
        let restored = UserDefaults.standard.bool(forKey: "pb_premium_unlocked")
        if restored {
            completion()
        }
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

class StoreDelegate: NSObject, SKProductsRequestDelegate {
    let completion: (Bool) -> Void
    
    init(completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let product = response.products.first {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        completion(false)
    }
}
