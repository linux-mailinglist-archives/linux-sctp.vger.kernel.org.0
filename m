Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22491CA396
	for <lists+linux-sctp@lfdr.de>; Fri,  8 May 2020 08:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEHGHc (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 8 May 2020 02:07:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40194 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgEHGHb (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 8 May 2020 02:07:31 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jWw3Z-00053g-CX; Fri, 08 May 2020 16:00:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 May 2020 16:07:01 +1000
Date:   Fri, 8 May 2020 16:07:01 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, cychiang@chromium.org,
        ecryptfs@vger.kernel.org, enric.balletbo@collabora.com,
        gilad@benyossef.com, groeck@chromium.org, jesper.nilsson@axis.com,
        k.konieczny@samsung.com, keyrings@vger.kernel.org, krzk@kernel.org,
        k.opasiak@samsung.com, lars.persson@axis.com,
        linux-bluetooth@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
        r.baldyga@samsung.com, thomas.lendacky@amd.com, vz@mleia.com,
        xuzaibo@huawei.com
Subject: Re: [PATCH 00/20] crypto: introduce crypto_shash_tfm_digest()
Message-ID: <20200508060700.GA24956@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502053122.995648-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> This series introduces a helper function crypto_shash_tfm_digest() which
> replaces the following common pattern:
> 
>        {
>                SHASH_DESC_ON_STACK(desc, tfm);
>                int err;
> 
>                desc->tfm = tfm;
> 
>                err = crypto_shash_digest(desc, data, len, out);
> 
>                shash_desc_zero(desc);
>        }
> 
> with:
> 
>        err = crypto_shash_tfm_digest(tfm, data, len, out);
> 
> Patch 1 introduces this helper function, and patches 2-20 convert all
> relevant users to use it.
> 
> IMO, it would be easiest to take all these patches through the crypto
> tree.  But taking just the "crypto:" ones and then me trying to get the
> rest merged later via subsystem trees is also an option.
> 
> Eric Biggers (20):
>  crypto: hash - introduce crypto_shash_tfm_digest()
>  crypto: arm64/aes-glue - use crypto_shash_tfm_digest()
>  crypto: essiv - use crypto_shash_tfm_digest()
>  crypto: artpec6 - use crypto_shash_tfm_digest()
>  crypto: ccp - use crypto_shash_tfm_digest()
>  crypto: ccree - use crypto_shash_tfm_digest()
>  crypto: hisilicon/sec2 - use crypto_shash_tfm_digest()
>  crypto: mediatek - use crypto_shash_tfm_digest()
>  crypto: n2 - use crypto_shash_tfm_digest()
>  crypto: omap-sham - use crypto_shash_tfm_digest()
>  crypto: s5p-sss - use crypto_shash_tfm_digest()
>  nfc: s3fwrn5: use crypto_shash_tfm_digest()
>  fscrypt: use crypto_shash_tfm_digest()
>  ecryptfs: use crypto_shash_tfm_digest()
>  nfsd: use crypto_shash_tfm_digest()
>  ubifs: use crypto_shash_tfm_digest()
>  Bluetooth: use crypto_shash_tfm_digest()
>  sctp: use crypto_shash_tfm_digest()
>  KEYS: encrypted: use crypto_shash_tfm_digest()
>  ASoC: cros_ec_codec: use crypto_shash_tfm_digest()
> 
> arch/arm64/crypto/aes-glue.c               |  4 +--
> crypto/essiv.c                             |  4 +--
> crypto/shash.c                             | 16 +++++++++
> drivers/crypto/axis/artpec6_crypto.c       | 10 ++----
> drivers/crypto/ccp/ccp-crypto-sha.c        |  9 ++---
> drivers/crypto/ccree/cc_cipher.c           |  9 ++---
> drivers/crypto/hisilicon/sec2/sec_crypto.c |  5 ++-
> drivers/crypto/mediatek/mtk-sha.c          |  7 ++--
> drivers/crypto/n2_core.c                   |  7 ++--
> drivers/crypto/omap-sham.c                 | 20 +++--------
> drivers/crypto/s5p-sss.c                   | 39 ++++------------------
> drivers/nfc/s3fwrn5/firmware.c             | 10 +-----
> fs/crypto/fname.c                          |  7 +---
> fs/crypto/hkdf.c                           |  6 +---
> fs/ecryptfs/crypto.c                       | 17 +---------
> fs/nfsd/nfs4recover.c                      | 26 ++++-----------
> fs/ubifs/auth.c                            | 20 ++---------
> fs/ubifs/master.c                          |  9 ++---
> fs/ubifs/replay.c                          | 14 ++------
> include/crypto/hash.h                      | 19 +++++++++++
> net/bluetooth/smp.c                        |  6 +---
> net/sctp/auth.c                            | 10 ++----
> net/sctp/sm_make_chunk.c                   | 23 +++++--------
> security/keys/encrypted-keys/encrypted.c   | 18 ++--------
> sound/soc/codecs/cros_ec_codec.c           |  9 +----
> 25 files changed, 95 insertions(+), 229 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
