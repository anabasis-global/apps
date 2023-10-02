oid function () {
  var ipop;
  module.exports = {
    ip4toint: function (ip) {
      return ip.split('.').reduce(function (a, b) {
        return (+a << 8) + +b;
      });
    },
    inttoip4: function (v) {
      return [
        24,
        16,
        8,
        0
      ].map(function (i) {
        return v >> i & 255;
      }).join('.');
    },
    ip4incidr: function (ip, cidr) {
      var cache$, cache$1, mask, masklen;
      cache$ = cidr.split('/');
      cidr = cache$[0];
      masklen = cache$[1];
      mask = masklen === '0' ? 0 : -1 << 32 - masklen;
      cache$1 = [
        ip,
        cidr
      ].map(function (ip) {
        return mask & ipop.ip4toint(ip);
      });
      ip = cache$1[0];
      cidr = cache$1[1];
      return ip === cidr;
    },
    cidr4: function (cidr) {
      var cache$, mask, masklen;
      cache$ = cidr.split('/');
      cidr = cache$[0];
      masklen = cache$[1];
      cidr = ipop.ip4toint(cidr);
      mask = masklen === '0' ? 0 : -1 << 32 - masklen;
      return {
        net: ipop.inttoip4(cidr & mask),
        netmask: ipop.inttoip4(mask),
        broadcast: ipop.inttoip4(cidr | ~mask),
        low: ipop.inttoip4((cidr & mask) + 1),
        high: ipop.inttoip4((cidr | ~mask) - 1),
        hosts: Math.pow(2, 32 - masklen) - 2
      };
    }
  };
  ipop = module.exports;
  if (!module.parent) {
    console.log(ipop.ip4incidr('192.168.1.15', '192.168.0.1/24'));
    console.log(ipop.ip4incidr('192.168.1.15', '192.168.0.1/16'));
    console.log(ipop.ip4incidr('192.168.1.15', '192.168.1.15/32'));
    console.log(ipop.cidr4('87.239.88.1/22'));
  }
}.call(this);
