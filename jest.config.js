module.exports = {
    "roots": [
        "<rootDir>"
    ],
    // Xác định nơi bỏ các file testing 
    // Thông thuòng ra sẽ bỏ các file typescript vào hết thư mục src
    "testMatch": [
        "**/__tests__/**/*.+(ts|tsx|js)",
        "**/?(*.)+(spec|test).+(ts|tsx|js)"
    ],
    // Jest sẽ dựa định dạng này để phát hiện các file 
    // cần được testing nhé
    "transform": {
        "^.+\\.(ts|tsx)$": "ts-jest"
    },
    // Thằng ts-jest sẽ xác định các file có dạng này
    // Sau đó sẽ biến đổi về dạng nó có thể hiểu được
    // Để chạy jest
    "moduleNameMapper": {
        "@shared/(.*)": "<rootDir>/src/shared/$1",
        "@helper/(.*)": "<rootDir>/src/helper/$1",
        "@src/(.*)": "<rootDir>/src/$1",
        "@daos/(.*)": "<rootDir>/src/daos/$1",
    },
    "verbose": true,
    // Báo cáo các bài test lúc đang chạy 
    "globals": {
        "ts-jest": {
            diagnostics: false
        }
    }
    // Ồ ồ cái này cần à nghe, cái này để các hàm
    // của thằng jest trở thành globals
    // không cần phải require hay import khi dùng nữa
}