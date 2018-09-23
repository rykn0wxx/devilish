require('../src/sass/authentication.scss');
require('../src/img/login.jpg');

import Mudhead from '../src/js/mudhead';
import MdInput from '../src/js/components/md_input';

Mudhead.addAfterPageLoadedEvent(MdInput.activate);
Mudhead.init();
