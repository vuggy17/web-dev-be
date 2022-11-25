export const replaceTemplate = (
  template: string,
  data: { key: string; value: string }[]
): string => {
  data.forEach((field) => {
    while (template.indexOf(`[[${field.key}]]`) >= 0) {
      template = template.replace(`[[${field.key}]]`, field.value);
    }
  });
  return template;
};
