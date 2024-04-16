//
//  ViewController.swift
//  ChartSamplesSwift
//
//  Created by Santhosh K on 07/04/24.
//

import UIKit

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}

import UIKit

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier = "CollapsibleTableViewHeader"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var section: Int = 0
    var delegate: CollapsibleTableViewHeaderDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        contentView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func headerTapped() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        arrowImageView.image = collapsed ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")
    }
}

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CollapsibleTableViewHeaderDelegate {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var sectionData: [[String]] = [["BarChartsVC1","BarChartsVC2","BarCharts3"], ["Row 1", "Row 2"], ["Row 1", "Row 2", "Row 3", "Row 4"]]
    var sectionTitles = ["Bar Charts", "Section 2", "Section 3"]
    var sectionCollapsed = [Bool](repeating: true, count: 3) // All sections are initially collapsed
    var expandedSection: Int? // Keep track of the currently expanded section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: CollapsibleTableViewHeader.reuseIdentifier)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCollapsed[section] ? 0 : sectionData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CollapsibleTableViewHeader.reuseIdentifier) as! CollapsibleTableViewHeader
        header.delegate = self
        header.section = section
        header.titleLabel.text = sectionTitles[section]
        header.titleLabel.textColor = .red
        header.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        header.setCollapsed(sectionCollapsed[section])
        return header
    }
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        // If another section is expanded, collapse it first
        if let expandedSection = expandedSection, expandedSection != section {
            sectionCollapsed[expandedSection] = true
            tableView.reloadSections(IndexSet(integer: expandedSection), with: .automatic)
        }
        
        // Toggle the state of the current section
        sectionCollapsed[section] = !sectionCollapsed[section]
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        
        // Update the currently expanded section
        expandedSection = sectionCollapsed[section] ? nil : section
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let name = sectionData[indexPath.section][indexPath.row]
            var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}
