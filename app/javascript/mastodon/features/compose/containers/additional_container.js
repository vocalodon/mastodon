import { connect }   from 'react-redux';
import AdditionalInfo from '../components/additional_info';

const mapStateToProps = state => {
  return {
    account: state.getIn(['accounts', state.getIn(['meta', 'me'])]),
  };
};

export default connect(mapStateToProps)(AdditionalInfo);

