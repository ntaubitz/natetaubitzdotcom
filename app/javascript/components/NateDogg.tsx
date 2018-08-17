import React from "react"
import PropTypes from "prop-types"
class NateDogg extends React.Component {
  render () {
    return (
      <React.Fragment>
        React Component says: {this.props.greeting}
      </React.Fragment>
    );
  }
}

NateDogg.propTypes = {
  greeting: PropTypes.string
};

export default NateDogg
