import $ from 'jquery';
import Keyboard from 'simple-keyboard';
import 'simple-keyboard/build/css/index.css';
import 'font-awesome/css/font-awesome.css'
import './index.css';

const origSpeccyWidth = 320;
const origSpeccyHeight = 240;
const keyboardHeight = 200;
const keyboardElement = $('#keyboard');
const speccyElement = $('#speccy');
const spacerElement = $('#spacer');

const keyCodes = {
    '{back}':  37,
    '{up}':    38,
    '{down}':  40,
    '{enter}': 13,
    '{break}': 48,
    '{run}':   82,
    1: 49,
    2: 50,
    3: 51,
    4: 52,
    5: 53,
    6: 54,
    7: 55,
    8: 56,
    9: 57
};

const keyboard = new Keyboard({
    onKeyPress: button => onKeyPress(button),
    layoutName: 'default',
    layout: {
        'default': [
            '1 2 3 4 5 6 7 8 9',
            '{back} {up} {enter}',
            '{break} {down} {run}',
        ]
    },
    display: {
        '{back}': '<i class="fa fa-backward"></i>',
        '{enter}': '<i class="fa fa-forward"></i>',
        '{up}': '<i class="fa fa-arrow-up"></i>',
        '{down}': '<i class="fa fa-arrow-down"></i>',
        '{break}': '<i class="fa fa-stop-circle-o"></i>',
        '{run}': '<i class="fa fa-play-circle-o"></i>',
    }

});

const speccy = JSSpeccy('speccy', {
    'autostart': true,
    'autoload': true,
    'scaleFactor': calcScaleFactor(),
    'loadFile': 'tap/program.tap'
});

speccy.setModel(JSSpeccy.Spectrum.MODEL_48K);
keyboardElement.width(speccyElement.width() * 0.8);

function onChange(input) {
}

function buttonToEvent(button) {
    return {keyCode: keyCodes[button]};
}

function onKeyPress(button) {
    document.onkeydown(buttonToEvent(button));
    setTimeout(() => {
        document.onkeyup(buttonToEvent(button));
    }, 100);
}

function calcScaleFactor() {
    const scaleFactor = Math.min(
        ($(window).height() - keyboardHeight) / origSpeccyHeight,
        $(window).width() / origSpeccyWidth
    );
    spacerElement.height($(window).height() - keyboardHeight - origSpeccyHeight * scaleFactor + 24);
    return scaleFactor;
}
