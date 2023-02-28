//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Rohmat Dasuki on 16/02/23.
//

import UIKit

enum Section: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Movie?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Trending Movies","Trending Tv", "Popular" ,"Upcoming Movies","Top Rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.indentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeaderView()
//        getTrendingMovies()
//        getTrendingTvs()
//        getPopular()
//        getUpcomingMovies()
//        getTopRated()
    }
    
    private func configureHeroHeaderView(){
        APICaller.shared.getTrendingMovies{[weak self] result in
            switch result {
            case .success(let titles):
                let selected = titles.randomElement()
                self?.randomTrendingMovie = titles.randomElement()
                self?.headerView?.configure(with: TitleViewModel(titleName:selected?.original_title ?? "" , posterURL: selected?.poster_path ?? "" ))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func PressedLogo() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        let button = UIButton(type: .system,primaryAction: UIAction(handler: { _ in
            self.PressedLogo()
        }))
        button.frame = CGRect(x:20, y: 0, width: 20, height: 35 )
        button.setImage(image, for: .normal)
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 35)));
        view.addSubview(button);

        let leftButton = UIBarButtonItem(customView: view)
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func getTopRated() {
        APICaller.shared.getTopRated{ result in
            switch result {
            case .success(let topRated):
                print(topRated)
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.indentifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }

        cell.delegate = self

        switch indexPath.section{
//           get data trending moview
            case Section.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
//            get data trending tv
            case Section.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
//            get data popular
            case Section.Popular.rawValue:
            APICaller.shared.getPopular{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
//            get data upcoming
            case Section.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
//            get data top rated
            case Section.TopRated.rawValue:
            APICaller.shared.getTopRated{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error)
                }
            }
//            default 
        default:
            return UITableViewCell() 
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
     
        
    }
    
        
}
