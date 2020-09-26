import {
  NOT_LOADED,
  LOAD_SOURCE_CODE, SKIP_BECAUSE_BROKEN
} from '../applications/apps.helper';
import {
  smellLikePromise,
  flattenLifecyclesArray,
} from './helper';

export function toLoadPromise(app) {
  if (app.status !== NOT_LOADED) {
    return Promise.resolve(app);
  }
  app.status = LOAD_SOURCE_CODE;

  let loadPromise = app.loadFunction();

  if (!smellLikePromise(loadPromise)) {
    return Promise.reject(new Error(''));
  }
  loadPromise.then(appConfig => {
    if (typeof appConfig !== 'object') {
      throw new Error('');
    }
    let errors = [];
    [
      'bootstrap',
      'mount',
      'unmount',
    ].forEach(lifecycle => {
      if (!appConfig[lifecycle]) {
        errors.push(`lifecycle: ${lifecycle} must be exists`);
      }
    });

    if (errors.length) {
      app.status = SKIP_BECAUSE_BROKEN;
      console.log(errors);
      return;
    }

    app.bootstrap = flattenLifecyclesArray(appConfig.bootstrap, `app: ${app.name} bootstrapping`);
    app.mount = flattenLifecyclesArray(appConfig.mount, `app: ${app.name} mounting`);
    app.unmount = flattenLifecyclesArray(appConfig.unmount, `app: ${app.name} unmounting`);

  })
}