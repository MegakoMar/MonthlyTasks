//
//  CompositionLayoutViewController.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import UIKit

final class CompositionLayoutViewController: UIViewController, UICollectionViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        configureDataSource()
    }

    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>?

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: configureLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            EmptyHeaderView.self,
            forSupplementaryViewOfKind: EmptyHeaderView.reuseIdentifier,
            withReuseIdentifier: EmptyHeaderView.reuseIdentifier
        )
        return collectionView
    }()

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func configureConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }

    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                ))
            item.contentInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)

            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .fractionalWidth(0.25)
                ),
                subitems: [item]
            )

            let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: CLDecoratorView.reuseIdentifier)
            sectionBackground.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.interGroupSpacing = 10
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.decorationItems = [
                sectionBackground
            ]

            let headerItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.8)
            )
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerItemSize,
                elementKind: EmptyHeaderView.reuseIdentifier,
                alignment: .top
            )

            section.boundarySupplementaryItems = [headerItem]

            return section
        }

        layout.register(CLDecoratorView.self, forDecorationViewOfKind: CLDecoratorView.reuseIdentifier)

        return layout
    }

    private func configureDataSource() {
        let cellsData: [[CLCellData]] = [
            [
                .init(color: .red),
                .init(color: .green)
            ],
            [
                .init(color: .red),
                .init(color: .green)
            ]
        ]

        let cellRegistration = UICollectionView.CellRegistration<CLCell, Int> { cell, indexPath, itemIdentifier in
            let sectionData = cellsData[indexPath.section]
            let cellData = sectionData[indexPath.item]

            cell.update(with: cellData)
        }

        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            guard let self else {
                return nil
            }

            return self.collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        dataSource?.supplementaryViewProvider = { [weak self]
            (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self, kind == EmptyHeaderView.reuseIdentifier else {
                return nil
            }

            let headerView = self.collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: EmptyHeaderView.reuseIdentifier,
                for: indexPath
            ) as? EmptyHeaderView

            guard let headerView else {
                return nil
            }

            return headerView
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 2

        for section in 0..<2 {
            snapshot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
