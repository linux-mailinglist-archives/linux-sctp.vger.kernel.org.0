Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0111E7D33
	for <lists+linux-sctp@lfdr.de>; Fri, 29 May 2020 14:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgE2M3Z (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 29 May 2020 08:29:25 -0400
Received: from verein.lst.de ([213.95.11.211]:32797 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2M3Y (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 29 May 2020 08:29:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B266C68B02; Fri, 29 May 2020 14:29:21 +0200 (CEST)
Date:   Fri, 29 May 2020 14:29:21 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/4] net: remove kernel_setsockopt
Message-ID: <20200529122921.GA28533@lst.de>
References: <20200529120943.101454-1-hch@lst.de> <20200529120943.101454-5-hch@lst.de> <d95348e2191046e9986860e3f1023491@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95348e2191046e9986860e3f1023491@AcuMS.aculab.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, May 29, 2020 at 12:27:12PM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 29 May 2020 13:10
> > 
> > No users left.
> 
> There is no point even proposing this until all the changes to remove
> its use have made it at least as far into 'net-next' and probably 'net'.

If you look at net-next, the only two users left are the two removed in
this series.
