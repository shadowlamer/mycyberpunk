const path = require('path');
const HtmlWebPackPlugin = require("html-webpack-plugin");
const CopyPlugin = require('copy-webpack-plugin');

const htmlWebpackPlugin = new HtmlWebPackPlugin({
    template: "./src/index.html",
    filename: "./index.html"
});

const copyPlugin = new CopyPlugin([
    { from: 'src/*.tap', to: '', force: true,
        transformPath(targetPath, absolutePath) {
            return 'tap/'+path.basename(targetPath);
        }
    },
    { from: 'src/jsspeccy/*.js', to: '',
        transformPath(targetPath, absolutePath) {
            return path.basename(targetPath);
        }
    },
]);

module.exports = {
    devServer: {
        contentBase: './src/jsspeccy'
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
                    {
                        loader: "style-loader"
                    },
                    {
                        loader: "css-loader",
                        options: {
                            modules: true,
                            importLoaders: 1,
                            localIdentName: "[local]",
                            sourceMap: true,
                            minimize: true
                        }
                    }
                ]
            },
            {
                test: /\.scss$/,
                loader: 'style-loader!css-loader!sass-loader'
            },
            {
                test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                use: [
                    {
                        loader: 'file-loader',
                        options: {
                            name: '[name].[ext]',
                            outputPath: 'fonts/'
                        }
                    }
                ]
            },
        ]
    },
    plugins: [
        htmlWebpackPlugin,
        copyPlugin
    ],
//    watch: true
};
