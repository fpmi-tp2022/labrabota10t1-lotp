// MARK: Description
// Данный класс предоставляет пользователю список отелей
// Пользователь может воспользоваться поиском города
// А также выбрать отель? информацию о котором хочет посмотреть



import UIKit

class HotelsViewController: BaseViewController {

    @IBOutlet weak var hotelsCollectionView: UICollectionView!
    @IBOutlet weak var findCityLabel: UITextField!
    
    
    var hotels: [[String: String]]?
    var hotelsByCity: [[String: String]]?
    var hotelTapped: [String: String]?
    
    @IBOutlet weak var tabBar: TabBarView!
    override func viewDidLoad() {
        super.viewDidLoad()

        hotels = ReadHotels.getPlist()
        hotelsByCity = hotels
        tabBar.delegate = self
        hotelsCollectionView.dataSource = self
        hotelsCollectionView.delegate = self
        hotelsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    // MARK: Выбор города
    @IBAction func findCityTapped(_ sender: Any) {
        if (findCityLabel.text != "") {
            hotelsByCity?.removeAll()
            let city = findCityLabel.text!
            for i in 0..<hotels!.count{
                //print("0 \(hotels![i]["city"])")
                if (NSLocalizedString(hotels![i]["city"]!, comment: "") == city) {
                    print("1 ++")
                    hotelsByCity?.append((hotels?[i])!)
                }
            }
            
            if (hotelsByCity!.count != 0) {
                //print("2 \(hotelsByCity!.count)")
                hotelsCollectionView.reloadData()
            }
            
        } else {
            if (hotelsByCity!.count != hotels!.count) {
                hotelsByCity = hotels
                hotelsCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HotelInfoViewController
        if let cell = sender as? UICollectionViewCell,
           let indexPath = self.hotelsCollectionView.indexPath(for: cell) {
            let hotel = hotelsByCity?[indexPath.row]
            vc.hotel = hotel
        }
    }
    
}

// MARK: CollectionView Delegate
extension HotelsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hotelsByCity?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelCollectionViewCell", for: indexPath) as! HotelCollectionViewCell
        
        print("3 \(indexPath.row)")
        cell.setup(with: (hotelsByCity?[indexPath.row])!)
        return cell
    }
}

extension HotelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500, height: 400)
    }
}

extension HotelsViewController: UICollectionViewDelegate {
    
}
