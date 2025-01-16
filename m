Return-Path: <linux-sctp+bounces-320-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F014FA1346A
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Jan 2025 08:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4BA1635AB
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Jan 2025 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E4193407;
	Thu, 16 Jan 2025 07:55:06 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F88158868
	for <linux-sctp@vger.kernel.org>; Thu, 16 Jan 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014106; cv=none; b=bObLcNODEjC/9yiMv9FDJvvX61r5FMo02FbtvpyvXFSYEaCgF34b6rWzla3pBuOBsvRv9E2oPrWCm7VeyqMxzZFdMDuOCG83Tw7G06d4Ev7OHf7503zBIJ+sMQ5YsmuM0XRLUWpkMFf07KIuuuK5DdiZJHNUMF4UF13iDulwmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014106; c=relaxed/simple;
	bh=7M65RmMX3Ry4OaGybSFFVt26wFFfaatRGurZ9wLro+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTNTN+bzI/nTf1JBR7lxNzqk/oVTF/jB1FASmzvqBN7aTQtCRUu3tLBudzmOgqI3xqcj+GMcj1J1Ffb+wbeHDkdRVQE9Njr8lgpjRE3Pks6JTb7sdrMYXnuZ0U8TLGSBPG/bAuBeIvD7PPStU8zi/iiHwG9jB6d1QhZg/XNIk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tYKhe-00075B-4S; Thu, 16 Jan 2025 08:54:10 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tYKhT-000DS3-0I;
	Thu, 16 Jan 2025 08:53:59 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 165233A99BF;
	Thu, 16 Jan 2025 07:53:43 +0000 (UTC)
Date: Thu, 16 Jan 2025 08:53:42 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
	Bernard Metzler <bmt@zurich.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>, 
	Mike Christie <michael.christie@oracle.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexander Aring <aahringo@redhat.com>, 
	David Teigland <teigland@redhat.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, David Ahern <dsahern@kernel.org>, 
	Joerg Reuter <jreuter@yaina.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Allison Henderson <allison.henderson@oracle.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Ying Xue <ying.xue@windriver.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Martin Schiller <ms@dev.tdt.de>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Guillaume Nault <gnault@redhat.com>, 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, Andrew Morton <akpm@linux-foundation.org>, 
	Wu Yunchuan <yunchuan@nfschina.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Maurizio Lombardi <mlombard@redhat.com>, David Howells <dhowells@redhat.com>, 
	Atte =?utf-8?B?SGVpa2tpbMOk?= <atteh.mailbox@gmail.com>, Vincent Duvert <vincent.ldev@duvert.net>, 
	Denis Kirjanov <kirjanov@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Huth <thuth@redhat.com>, 
	Andrew Waterman <waterman@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Andrej Shadura <andrew.shadura@collabora.co.uk>, Ying Hsu <yinghsu@chromium.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Tom Parkin <tparkin@katalix.com>, 
	Jason Xing <kernelxing@tencent.com>, Dan Carpenter <error27@gmail.com>, Hyunwoo Kim <v4bel@theori.io>, 
	Bernard Pidoux <f6bvp@free.fr>, Sangsoo Lee <constant.lee@samsung.com>, 
	Doug Brown <doug@schmorgal.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Gou Hao <gouhao@uniontech.com>, Mina Almasry <almasrymina@google.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Yajun Deng <yajun.deng@linux.dev>, Michal Luczaj <mhal@rbox.co>, 
	Jiri Pirko <jiri@resnulli.us>, syzbot <syzkaller@googlegroups.com>, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com, 
	linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org, target-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
Message-ID: <20250116-light-panda-of-reverence-2f5da8-mkl@pengutronix.de>
References: <20241217023417.work.145-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbdyd5ky7ajuduf3"
Content-Disposition: inline
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-sctp@vger.kernel.org


--nbdyd5ky7ajuduf3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
MIME-Version: 1.0

On 16.12.2024 18:34:28, Kees Cook wrote:
> The proto_ops::getname callback was long ago backed by sockaddr_storage,
> but the replacement of it for sockaddr was never done. Plumb it through
> all the getname() callbacks, adjust prototypes, and fix casts.
>=20
> There are a few cases where the backing object is _not_ a sockaddr_storage
> and converting it looks painful. In those cases, they use a cast to
> struct sockaddr_storage. They appear well bounds-checked, so the risk
> is no worse that we have currently.
>=20
> Other casts to sockaddr are removed, though to avoid spilling this
> change into BPF (which becomes a much larger set of changes), cast the
> sockaddr_storage instances there to sockaddr for the time being.
>=20
> In theory this could be split up into per-caller patches that add more
> casts that all later get removed, but it seemed like there are few
> enough callers that it seems feasible to do this in a single patch. Most
> conversions are mechanical, so review should be fairly easy. (Famous
> last words.)
>=20
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  net/can/isotp.c                               |  3 +-
>  net/can/j1939/socket.c                        |  2 +-
>  net/can/raw.c                                 |  2 +-

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for net/can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nbdyd5ky7ajuduf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmeIuv8ACgkQKDiiPnot
vG/tCQgAnoYMQthE5qhN4islXZibYx3HOEVpQp20V/CdVVRH56MNpoQvsjN0F5I9
Pe8FiGuyUR9fNqhHJPDV5qTZfzq6vRSoc7PpwLTwF9ReyzpbKcMrYcmv/Wkbso1k
faQaG0U/F/5wp2/nsK1h/PUHRvlwFfLs41wCCmlXQDks5vvt1U+8F/0mUiM/L0yT
SQG9iudLNDMEv22xlkR1e90s94ARgRIKcBcOZ9LudgYLwGmT8I3JAenyHET3Q8d2
GWVaepqliLBxoq7pfWcJm1yFL8DFp2xSUy/gP7BqrfKIJoJhRqOR2EXGSgAZ6rek
c/YmUBVaGDu2ZBkxhzlB6NKXFu9dBA==
=LAEY
-----END PGP SIGNATURE-----

--nbdyd5ky7ajuduf3--

