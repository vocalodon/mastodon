import React from 'react';
import SearchContainer from 'mastodon/features/compose/containers/search_container';
import ComposeFormContainer from 'mastodon/features/compose/containers/compose_form_container';
import NavigationContainer from 'mastodon/features/compose/containers/navigation_container';
import LinkFooter from './link_footer';
import AdditionalContainer from 'mastodon/features/compose/containers/additional_container';

const ComposePanel = () => (
  <div className='compose-panel'>
    <SearchContainer openInRoute />
    <NavigationContainer />
    <ComposeFormContainer singleColumn />
    <AdditionalContainer />
    <LinkFooter withHotkeys />
  </div>
);

export default ComposePanel;
