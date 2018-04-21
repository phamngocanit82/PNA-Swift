import UIKit
protocol DownloadServiceDelegate: NSObjectProtocol {
    func progressValue(_ percent: Float)
    func finishDownload(_ _data: NSData)
    func errorDownload()
}

class DownloadService: NSObject, URLSessionDownloadDelegate {
    var url : URL?
    weak var delegate: DownloadServiceDelegate?
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if (delegate != nil) {
            guard let dataFromURL = NSData(contentsOf: location) else {return}
            self.delegate?.finishDownload(dataFromURL)
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if (delegate != nil) {
            self.delegate?.progressValue(Float(bytesWritten / totalBytesWritten))
        }
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if(error != nil) {
            print("Download completed with error: \(error!.localizedDescription)")
        }
        if (delegate != nil) {
            self.delegate?.errorDownload()
        }
    }
    func download(url: URL) {
        self.url = url
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: url.absoluteString)
        let session = Foundation.URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        task.resume()
    }
}
