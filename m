Return-Path: <linux-sctp+bounces-292-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A9D9F4177
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Dec 2024 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F36168777
	for <lists+linux-sctp@lfdr.de>; Tue, 17 Dec 2024 04:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36014B07A;
	Tue, 17 Dec 2024 03:59:59 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116714601C;
	Tue, 17 Dec 2024 03:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734407999; cv=none; b=P33K3vy44PjuY1YCruAHsYMuxBECvbr/nn2PI/uJmIaideXIX/LZ58frXMQGf17pbFYkT+SfEyfm0jsYrK2gkvRiTTe0+y9BD5i7FRftrUnN1J9ZB6dS/tYBdLGgQji8gxLwhuWbofgN3/b+x2g/9QKKZ1Pzw/95fJfEzWRrsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734407999; c=relaxed/simple;
	bh=GXKY4ibAqf+fScHyj3FgJPIYI3um2k9fkI7luLsdvHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkaaLAM/nzdoysZ/sJkmrmdr8zjYjiFbZ070p48GQNcbh+YQ4UOGvi6IS8QoHD/Jb2szDqKDo38X00RMYNPjtaR9Drsye42aTmAiLsSUUzFP3riYmdJxd6EnppCFt70VhQwK5IhQ2wscER1gf7PIsyTkd+HkPrNna+igjGCFvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E68768C4E; Tue, 17 Dec 2024 04:59:43 +0100 (CET)
Date: Tue, 17 Dec 2024 04:59:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <kees@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Karsten Keil <isdn@linux-pingi.de>,
	Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, David Ahern <dsahern@kernel.org>,
	Joerg Reuter <jreuter@yaina.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	James Chapman <jchapman@katalix.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Martin Schiller <ms@dev.tdt.de>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Guillaume Nault <gnault@redhat.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wu Yunchuan <yunchuan@nfschina.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Atte =?iso-8859-1?Q?Heikkil=E4?= <atteh.mailbox@gmail.com>,
	Vincent Duvert <vincent.ldev@duvert.net>,
	Denis Kirjanov <kirjanov@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Huth <thuth@redhat.com>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrej Shadura <andrew.shadura@collabora.co.uk>,
	Ying Hsu <yinghsu@chromium.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Tom Parkin <tparkin@katalix.com>,
	Jason Xing <kernelxing@tencent.com>,
	Dan Carpenter <error27@gmail.com>, Hyunwoo Kim <v4bel@theori.io>,
	Bernard Pidoux <f6bvp@free.fr>,
	Sangsoo Lee <constant.lee@samsung.com>,
	Doug Brown <doug@schmorgal.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Gou Hao <gouhao@uniontech.com>,
	Mina Almasry <almasrymina@google.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Yajun Deng <yajun.deng@linux.dev>, Michal Luczaj <mhal@rbox.co>,
	Jiri Pirko <jiri@resnulli.us>, syzbot <syzkaller@googlegroups.com>,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	target-devel@vger.kernel.org, gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-hams@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
	linux-s390@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: Convert proto_ops::getname to sockaddr_storage
Message-ID: <20241217035943.GB14719@lst.de>
References: <20241217023417.work.145-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217023417.work.145-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Would be nice to avoid a bunch of the overly long lines, but the
fundamental changes looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

