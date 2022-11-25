export default function formatMoney(n: number) {
  const formatter = new Intl.NumberFormat("vi-VI", {
    style: "currency",
    currency: "VND",
  });

  return formatter.format(n);
}


