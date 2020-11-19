import React from './react';
import ReactDOM from './react-dom';
let root = document.getElementById('root');
let ThemeContext = React.createContext();
// ThemeContext = {Provider, Consumer}

class Header extends React.Component {
  render() {
    return (
      <ThemeContext.Consumer>
        {
          (value) => (
            <div style={{ border: `5px solid ${value.color}`, padding: '5px' }}>
              header
              <Title />
            </div>
          )
        }
      </ThemeContext.Consumer>
    )
  }
}
class Title extends React.Component {
  render() {
    return (
      <ThemeContext.Consumer>
        {
          (value) => (
            <div style={{ border: `5px solid ${value.color}`, padding: '5px' }}>
              title
            </div>
          )
        }
      </ThemeContext.Consumer>
    )
  }
}
class Main extends React.Component {
  render() {
    return (
      <ThemeContext.Consumer>
        {
          (value) => (
            <div style={{ border: `5px solid ${value.color}`, padding: '5px' }}>
              main
              <Content />
            </div>
          )
        }
      </ThemeContext.Consumer>
    )
  }
}
class Content extends React.Component {
  render() {
    return (
      <ThemeContext.Consumer>
        {
          (value) => (
            <div style={{ border: `5px solid ${value.color}`, padding: '5px' }}>
              content
              <button onClick={() => value.changeColor('red')}>red</button>
              <button onClick={() => value.changeColor('green')}>green</button>
            </div>
          )
        }
      </ThemeContext.Consumer>
    )
  }
}
class Page extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      color: 'red',
    };
  }
  changeColor = (color) => {
    this.setState({color});
  }
  render() {
    let value = {
      color: this.state.color,
      changeColor: this.changeColor,
    };
    let style = {
      margin: '10px',
      border: `5px solid ${this.state.color}`,
      padding: '5px', height: '200px',
    };
    return (
      <ThemeContext.Provider value={value}>
        <div style={style}>
          <Header />
          <Main />
        </div>
      </ThemeContext.Provider>
    )
  }
}

ReactDOM.render(<Page />, root);