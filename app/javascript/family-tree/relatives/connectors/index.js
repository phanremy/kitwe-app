import { parents } from 'family-tree/relatives/connectors/parents';
import { middle } from 'family-tree/relatives/connectors/middle';
import { children } from 'family-tree/relatives/connectors/children';
import { childrenMiddle } from 'family-tree/relatives/connectors/childrenMiddle';
import { parentsMiddle } from 'family-tree/relatives/connectors/parentsMiddle';

const toConnectors = (families) => (fn) => fn(families);
export const connectors = (families) => ([parents, middle, children].map(toConnectors(families)).flat());
export const middleAddOns = (families) => ([parentsMiddle, middle, childrenMiddle].map(toConnectors(families)).flat());
//# sourceMappingURL=index.js.map
