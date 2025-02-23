//
//  MainViewController.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import UIKit

final class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDataSource()
    }

    private enum Section {
        case main
    }

    private let cellsData = MainEntities.allCases

    private var dataSource: UICollectionViewDiffableDataSource<Section, MainEntities>?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: configureLayout()
        )
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        collectionView.delegate = self
        return collectionView
    }()

    private func configureUI() {
        title = "Задания"
        view.backgroundColor = .red

        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }

    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            )

            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)

            return section
        }
        return layout
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MainEntities>(collectionView: collectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, entity: MainEntities) -> UICollectionViewCell? in
            guard let self else {
                return nil
            }

            let cell = self.collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCell.reuseIdentifier,
                for: indexPath
            ) as? MainCell

            guard let cell else {
                return nil
            }

            cell.update(with: .init(title: entity.title))

            return cell
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, MainEntities>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellsData)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var viewController: UIViewController

        switch cellsData[indexPath.item] {
        case .februaryEasy:
            viewController = StarsViewController()
        case .februaryMedium:
            viewController = CompositionLayoutViewController()
        }

        navigationController?.pushViewController(viewController, animated: true)
    }
}
