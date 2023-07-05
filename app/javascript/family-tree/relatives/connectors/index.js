import { parents } from 'family-tree/relatives/connectors/parents';
import { middle } from 'family-tree/relatives/connectors/middle';
import { children } from 'family-tree/relatives/connectors/children';

const toConnectors = (families) => (fn) => fn(families);
export const connectors = (families) => ([parents, middle, children].map(toConnectors(families)).flat());
//# sourceMappingURL=index.js.map
