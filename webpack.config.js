const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');

module.exports = {
    devServer: {
        static: './src/jsspeccy'
    },
    module: {
        rules: [
            {
                test: /\.js$/i,
                exclude: [
                    /node_modules/,
                    /jsspeccy/
                ],
                use: {
                    loader: "babel-loader"
                }
            },
            {
                test: /\.css$/i,
                use: [
                    "style-loader",
                    "css-loader"
                ]
            },
            {
                test: /\.(woff2?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                type: 'asset/resource',
                generator: {
                    filename: 'fonts/[name][ext]'
                }
            },
        ]
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: "./src/index.html",
            filename: "./index.html"
        }),
        new CopyPlugin({
            patterns: [
                { from: 'src/*.tap', to: 'tap/[name][ext]', noErrorOnMissing: true },
                { from: 'src/jsspeccy/*.js', to: '[name][ext]', noErrorOnMissing: true },
            ],
        })
    ],
};
