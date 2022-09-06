//
//  ContentView.swift
//  BundleSample
//
//  Created by Alexander von Below on 06.09.22.
//

import SwiftUI

struct ContentView: View {
    @State var image: UIImage?
    @AppStorage("path") var defaultsPath: String = ""
    
    var body: some View {
        VStack {
            if let display = image {
                Image(uiImage: display)
                    .padding()

            } else {
                Image(systemName: "gear")
                    .padding()
            }

            Button("Test Resource Bundle") {
                guard let url = bundlePath() else {
                    NSLog("Unable to find bundle")
                    return
                }
                testBundle(url: url)
            }
            .padding()
            Button("Copy Bundle") {
                guard let url = bundlePath() else {
                    NSLog ("Unable to find bundle")
                    return
                }
                guard let documentDirURL = self.bundleDocumentsPath() else {
                    NSLog ("Unable to find document dir")
                    return
                }
                do {
                    try FileManager.default.copyItem(
                        atPath: url.path,
                        toPath: documentDirURL.path)
                }
                catch let error {
                    NSLog ("Unable to copy file \(error)")
                }
            }
            .padding()
            Button ("Test Documents Bundle") {
                guard let documentDirURL = self.bundleDocumentsPath() else {
                    NSLog ("Unable to find document dir")
                    return
                }
                defaultsPath = documentDirURL.absoluteString
                guard let newURL = URL(string: defaultsPath) else {
                    NSLog("Could not create path")
                    return
                }
                    testBundle(url: newURL)
            }
            .padding()
            Button ("Clear Image") {
                self.image = nil
            }
            .padding()
        }
        .padding()
        .onAppear() {
            guard let newURL = URL(string: defaultsPath) else {
                NSLog("No path in defaults")
                return
            }
            testBundle(url: newURL)
        }
    }
    private func bundlePath() -> URL? {
        let bundleURL = Bundle.main.url(
            forResource: "Sample",
            withExtension: "quizlist")
        return bundleURL
    }
    
    private func bundleDocumentsPath() -> URL? {
        guard var documentDirURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else {
            return nil
        }
        let filename = "Sample.quizlist"
        if #available(iOS 16.0, *) {
            documentDirURL.append(component: filename)
        } else {
            let path = documentDirURL.absoluteString as NSString
            if let newURL = URL(string: path.appendingPathComponent(filename)) {
                documentDirURL = newURL
            }
        }

        return documentDirURL
    }
    
    private func testBundle(url: URL) {
        guard let bundle = Bundle(url: url) else {
            NSLog ("Unable to create Bundle at \(url)")
            return
        }
        guard let imageURL = bundle.url(forResource: "Image", withExtension: "jpeg") else {
            NSLog ("Unable to find image")
            return
        }
        guard let bundleImage = UIImage(contentsOfFile: imageURL.path) else {
            NSLog("Unable to create image")
            return
        }
        self.image = bundleImage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
