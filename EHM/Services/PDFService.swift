//
//  PDFService.swift
//  EHM
//
//  Created by Александр Бекренев on 17.01.2023.
//

import UIKit
import PDFGenerator

final class PDFService<TModel: Decodable>: NSObject {
    private let pdfView: UIView
    private let pdfTitle: String
    private let modelType: TModel.Type
    private var pdfURL: URL?

    private weak var delegate: PDFServiceDelegate?

    init(delegate: PDFServiceDelegate, title: String, view: UIView, type: TModel.Type) {
        self.delegate = delegate
        self.pdfTitle = title
        self.pdfView = view
        self.modelType = type
    }

    func removePDF() {
        guard let pdfURL = pdfURL else { return }

        let fileManager = FileManager()
        do {
            try fileManager.removeItem(at: pdfURL)
        } catch {
            print(error)
        }
    }

    @objc func sharePDF() {
        generatePDF()
        guard let pdfURL = pdfURL, let pdfData = NSData(contentsOf: pdfURL) else { return }

        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        delegate?.presentPDFActivityController(vc: activityViewController)
    }

    private func generatePDF() {
        let view = pdfView
        view.backgroundColor = .black

        let dashedTitle = pdfTitle.split(separator: " ").joined(separator: "-")

        let path = NSTemporaryDirectory().appending("\(dashedTitle)-\(chooseNameForPDF(for: modelType)).pdf")
        pdfURL = URL(fileURLWithPath: path)

        do {
            guard let pdfURL = pdfURL else { return }
            try PDFGenerator.generate([view], to: pdfURL)
        } catch {
            print(error)
        }
        delegate?.fixConstraints()
    }

    private func chooseNameForPDF<T>(for type: T.Type) -> String {
        switch type {
        case is Album.Type:
            return ModelsEnum.album.rawValue
        case is Band.Type:
            return ModelsEnum.band.rawValue
        case is Member.Type:
            return ModelsEnum.member.rawValue
        case is Song.Type:
            return ModelsEnum.song.rawValue
        case is SearchResult.Type:
            return ModelsEnum.search.rawValue
        default:
            return ModelsEnum.album.rawValue
        }
    }
}

protocol PDFServiceDelegate: AnyObject {
    func presentPDFActivityController(vc: UIViewController)
    func fixConstraints()
}
