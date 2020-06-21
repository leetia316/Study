"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var Originator_1 = __importDefault(require("./Originator"));
var CareTaker_1 = __importDefault(require("./CareTaker"));
var originator = new Originator_1.default();
var careTaker = new CareTaker_1.default();
originator.setState('State #1');
originator.setState('State #2');
careTaker.add(originator.saveStateToMemento());
originator.setState('State #3');
careTaker.add(originator.saveStateToMemento());
originator.setState('State #4');
console.log("Current State: " + originator.getState());
originator.getStateFromMemento(careTaker.get(0));
console.log("First saved State: " + originator.getState());
originator.getStateFromMemento(careTaker.get(1));
console.log("Second saved State: " + originator.getState());
