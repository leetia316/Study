import Color from './Color'

export default class Red implements Color {
  fill(): void {
    console.log('Inside Red::fill() method.')
  }
}