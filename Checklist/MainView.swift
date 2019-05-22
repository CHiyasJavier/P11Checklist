//
//  MainView.swift
//  Checklist
//
//  Created by Celiña Hiyas Javier on 17/05/2019.
//  Copyright © 2019 Celiña Hiyas Javier. All rights reserved.
//

import UIKit
import SnapKit

public final class MainView: UIView {

    // MARK: - Subviews
    public let tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        view.backgroundColor = UIColor.white
        view.showsVerticalScrollIndicator = true
        view.allowsSelection = false
        view.rowHeight = UITableView.automaticDimension
        view.separatorColor = UIColor.clear
        return view
    }()
    
    // MARK: - Stored Properties
    private var sectionInfoList: [SectionInfo] = [SectionInfo]()
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.subviews(forAutoLayout: [self.tableView])
        
        self.tableView.register(
            ItemWithTextInputCell.self,
            forCellReuseIdentifier: ItemWithTextInputCell.identifier)
        
       self.tableView.register(
            ChecklistItemHeaderView.self,
            forHeaderFooterViewReuseIdentifier: ChecklistItemHeaderView.identifier)
        
        self.tableView.register(ChecklistWithAnswerHeaderView.self, forHeaderFooterViewReuseIdentifier: ChecklistWithAnswerHeaderView.identifier)
        
        self.tableView.snp.remakeConstraints { (make: ConstraintMaker) in
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Sample Data
        let sectionInfoA: SectionInfo = SectionInfo(title: "Section 0", items: ["A"])
        let sectionInfoB: SectionInfo = SectionInfo(title: "Section 1", items: ["A"])
        let sectionInfoC: SectionInfo = SectionInfo(title: "Section 2", items: ["A"])
        let sectionInfoD: SectionInfo = SectionInfo(
            title: "Section 3",
            items: ["A"],
            withInput: "Je suis génial 1",
            isEditInput: true
        )
        
        let sectionInfoE: SectionInfo = SectionInfo(
            title: "Section 4",
            items: ["A"],
            withInput: "Je suis génial 2",
            isEditInput: true
        )
        
        let sectionInfoF: SectionInfo = SectionInfo(
            title: "Section 5",
            items: ["A"],
            withInput: "Je suis génial 3",
            isEditInput: true
        )
        self.sectionInfoList = [sectionInfoA, sectionInfoB, sectionInfoC, sectionInfoD, sectionInfoE, sectionInfoF]
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionInfoList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.sectionInfoList[section]
        switch sectionInfo.isExpanded {
        case true:
            return sectionInfo.items.count
        case false:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell: ItemWithTextInputCell = tableView.dequeueReusableCell(withIdentifier: ItemWithTextInputCell.identifier,
                for: indexPath
                ) as? ItemWithTextInputCell
        else { return UITableViewCell() }
        
        let sectionInfo = self.sectionInfoList[indexPath.section]
        cell.configure(with: sectionInfo, delegate: self, sectionIndex: indexPath.section)
        return cell
    }
}

extension MainView: UITableViewDelegate {
   
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionInfo = self.sectionInfoList[section]
        
        switch sectionInfo.isEditInput {
        case true:
            guard
                let checklistWithAsnwerHeaderView: ChecklistWithAnswerHeaderView = self.tableView.dequeueReusableHeaderFooterView(
                    withIdentifier: ChecklistWithAnswerHeaderView.identifier
                ) as? ChecklistWithAnswerHeaderView
            else { return UIView() }
            
            checklistWithAsnwerHeaderView.setTitle(sectionInfo.title ?? "")
            checklistWithAsnwerHeaderView.setSubTitle(sectionInfo.supportingAnswer)
            checklistWithAsnwerHeaderView.setSection(section)
            checklistWithAsnwerHeaderView.delegate = self
            
            let expandedSection: [SectionInfo] = self.sectionInfoList.filter({ $0.isExpanded} )
            
            switch expandedSection.count > 0 && sectionInfo.isExpanded == false {
            case true:
                checklistWithAsnwerHeaderView.addMasking()
            case false:
                checklistWithAsnwerHeaderView.removeMasking()
            }
            
            return checklistWithAsnwerHeaderView
        case false:
            guard
                let checklistItemHeaderView: ChecklistItemHeaderView = self.tableView.dequeueReusableHeaderFooterView(
                    withIdentifier: ChecklistItemHeaderView.identifier
                ) as? ChecklistItemHeaderView
            else { return UIView() }
            
            checklistItemHeaderView.setTitle(sectionInfo.title ?? "")
            checklistItemHeaderView.setSection(section)
            checklistItemHeaderView.delegate = self
            checklistItemHeaderView.checkboxButton.isSelected = sectionInfo.isExpanded
            
            let expandedSection: [SectionInfo] = self.sectionInfoList.filter({ $0.isExpanded} )
            
            switch expandedSection.count > 0 && sectionInfo.isExpanded == false {
            case true:
                checklistItemHeaderView.addMasking()
            case false:
                checklistItemHeaderView.removeMasking()
            }
            
            return checklistItemHeaderView
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionInfo = self.sectionInfoList[section]
        if sectionInfo.isEditInput {
            return 70.0
        }
        return 35.0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }

}

extension MainView: ChecklistItemHeaderViewDelegate {
    
    public func didToggleCheckbox(_ section: Int) {
        let sectionInfo: SectionInfo = self.sectionInfoList[section]
        sectionInfo.isExpanded.toggle()
        
        switch !sectionInfo.supportingAnswer.isEmpty {
        case true:
            sectionInfo.supportingAnswer = ""
        case false:
            break
        }
        
        self.tableView.reloadData()
    }
}

extension MainView: ChecklistWithAnswerHeaderViewDelegate {
    
    public func didTap(_ section: Int) {
        let sectionInfo: SectionInfo = self.sectionInfoList[section]
        switch sectionInfo.isExpanded {
        case true:
            sectionInfo.isExpanded = false
            sectionInfo.isEditInput = true
        case false:
            sectionInfo.isExpanded = true
            sectionInfo.isEditInput = false
        }
        self.tableView.reloadData()
    }
}

extension MainView: ItemWithTextInputCellDelegate {
    public func cancelTapped(on sectionIndex: Int) {
        let sectionInfo: SectionInfo = self.sectionInfoList[sectionIndex]
        sectionInfo.isExpanded = false
        self.tableView.reloadData()
    }
    
    
    public func saveTapped(on sectionIndex: Int) {
        let sectionInfo: SectionInfo = self.sectionInfoList[sectionIndex]
        switch sectionInfo.isExpanded {
        case true:
            sectionInfo.isExpanded = false
            sectionInfo.isEditInput = true
        case false:
            sectionInfo.isExpanded = true
            sectionInfo.isEditInput = false
        }
        self.tableView.reloadData()
    }
}

