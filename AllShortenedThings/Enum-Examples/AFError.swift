//
//  AFError.swift
//  AllShortenedThings
//
//  Created by Hasan Dag on 14.12.2021.
//

import Foundation
import Alamofire

/* Also Can add an activity or alert view for localized error
 type to create error description in cases with UIScreen
 Example: Decoding error in alert view with pop up typed and Base Service return that error type
 */

public enum AFError: Error {
    
    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
//    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
//    case responseValidationFailed(reason: ResponseValidationFailureReason)
//    case responseSerializationFailed(reason: ResponseSerializationFailureReason)

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }

    public var underlyingError: Error? {
        switch self {
        case .parameterEncodingFailed(let reason):
            return reason as? Error
//        case .multipartEncodingFailed(let reason):
//            return reason.underlyingError
//        case .responseSerializationFailed(let reason):
//            return reason.underlyingError
        default:
            return nil
        }
    }

}

extension AFError {
    /// Returns whether the AFError is an invalid URL error.
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
}
